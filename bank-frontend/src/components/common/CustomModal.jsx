/* eslint-disable react-hooks/set-state-in-effect */
import React, { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import styles from './CustomModal.module.css';

const CustomModal = ({
                         isOpen,
                         onClose,
                         onDismiss, // 배경 클릭/ESC/× 로 닫을 때의 동작(미지정 시 onClose)
                         title,
                         children,
                         onConfirm,
                         onCancel,
                         confirmText = '확인',
                         cancelText, // 기본값을 없애고, prop 존재 여부로 판단
                         duration = 0,
                         noAutoClose = false, // true 이면 onConfirm 후 자동 닫힘 안 함
                     }) => {
    const [isRendered, setIsRendered] = useState(false);
    const [isAnimate, setIsAnimate] = useState(false);
    // 명시적 버튼 외(배경/ESC/×) 닫힘 시 동작. 미지정 시 단순 닫기.
    const dismiss = onDismiss || onClose;

    useEffect(() => {
        if (isOpen) {
            setIsRendered(true);
            // 브라우저 렌더링 사이클을 고려한 짧은 지연
            const timer = setTimeout(() => setIsAnimate(true), 10);

            if (duration > 0) {
                const autoCloseTimer = setTimeout(onClose, duration);
                return () => clearTimeout(autoCloseTimer);
            }
            return () => clearTimeout(timer);
        } else {
            setIsAnimate(false);
        }
    }, [isOpen, duration, onClose]);

    useEffect(() => {
        const handleEscape = (e) => {
            if (e.key === 'Escape') dismiss();
        };
        if (isOpen) document.addEventListener('keydown', handleEscape);
        return () => document.removeEventListener('keydown', handleEscape);
    }, [isOpen, dismiss]);

    const handleTransitionEnd = (e) => {
        // opacity 트랜지션이 끝나고, 닫히는 중(isAnimate가 false)일 때만 DOM 제거
        if (e.propertyName === 'opacity' && !isAnimate) {
            setIsRendered(false);
        }
    };

    const handleCancelClick = () => {
        if (onCancel) {
            onCancel();
        }
        onClose();
    };

    const handleConfirmClick = () => {
        if (onConfirm) {
            onConfirm();
        }
        if (!noAutoClose) {
            onClose();
        }
    };

    if (!isRendered) return null;

    return createPortal(
        <div
            className={`${styles.overlay} ${isAnimate ? styles.isOpen : ''}`}
            onClick={(e) => e.target === e.currentTarget && dismiss()}
            onTransitionEnd={handleTransitionEnd}
        >
            <div className={styles.modalBox}>
                <div className={styles.header}>
                    <span>{title}</span>
                    <span className={styles.closeBtn} onClick={dismiss}>&times;</span>
                </div>

                <div className={styles.content}>
                    {children}
                </div>

                {(onConfirm || cancelText) && (
                    <div className={styles.footer}>
                        {cancelText && (
                            <button
                                className={`${styles.modalBtn} ${styles.cancel}`}
                                onClick={handleCancelClick}
                            >
                                {cancelText}
                            </button>
                        )}
                        {onConfirm && (
                            <button
                                className={`${styles.modalBtn} ${styles.confirm}`}
                                onClick={handleConfirmClick}
                            >
                                {confirmText}
                            </button>
                        )}
                    </div>
                )}
            </div>
        </div>,
        document.body
    );
};

export default CustomModal;
