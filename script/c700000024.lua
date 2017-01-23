--Scripted by Eerie Code
--Performage Overlay Juggler
function c700000024.initial_effect(c)
	--Pendulum Summon
	aux.EnablePendulumAttribute(c)
	--Xyz to material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetTarget(c700000024.xmtg)
	e2:SetOperation(c700000024.xmop)
	c:RegisterEffect(e2)
	--Attach
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c700000024.xyztg)
	e3:SetOperation(c700000024.xyzop)
	c:RegisterEffect(e3)
end

function c700000024.xmfil1(c,tp)
	return c:IsType(TYPE_XYZ) and Duel.IsExistingMatchingCard(c700000024.xmfil2,tp,LOCATION_MZONE,0,1,c,c)
end
function c700000024.xmfil2(c,xyzmat)
	return c:IsType(TYPE_XYZ) and xyzmat:IsCanBeXyzMaterial(c)
end
function c700000024.xmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c700000024.xmfil1(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c700000024.xmfil1,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c700000024.xmfil1,tp,LOCATION_MZONE,0,1,1,nil,tp)
end
function c700000024.xmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c700000024.xmfil2,tp,LOCATION_MZONE,0,1,1,tc,tc)
		if g:GetCount()>0 and not g:GetFirst():IsImmuneToEffect(e) then
			if tc:GetOverlayCount()>0 then
				Duel.SendtoGrave(tc:GetOverlayGroup(),REASON_RULE)
			end
			Duel.Overlay(g:GetFirst(),Group.FromCards(tc))
		end
	end
end

function c700000024.xyztg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c700000024.xmfil2(chkc,e:GetHandler()) end
	if chk==0 then return Duel.IsExistingTarget(c700000024.xmfil2,tp,LOCATION_MZONE,0,1,nil,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c700000024.xmfil2,tp,LOCATION_MZONE,0,1,1,nil,e:GetHandler())
end
function c700000024.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	end
end
